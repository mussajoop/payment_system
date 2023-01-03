require 'csv'

namespace :after_party do
  desc 'Deployment task: imports new merchants and admins from a csv file'
  task import_users: :environment do
    puts "Running deploy task 'import_users'"
    csv_file_path = File.read(Rails.root.join("lib/assets/users.csv"))
    csv = CSV.parse(csv_file_path, col_sep: ",", row_sep: :auto, skip_blanks: true)
    imported_users = []
    csv.each_with_index do |row, index|
      next if index == 0
      imported_users << { type: row[0], email: row[1], name: row[2], description: row[3], password: row[4], status: row[5] }
    end

    User.create!(imported_users)

    # Update task as completed.  If you remove the line below, the task will
    # run with every deploy (or every time you call after_party:run).
    AfterParty::TaskRecord
      .create version: AfterParty::TaskRecorder.new(__FILE__).timestamp
  end
end