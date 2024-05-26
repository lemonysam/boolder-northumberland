class AddHistoryNoteToProblems < ActiveRecord::Migration[7.1]
  def change
    add_column :problems, :history_note, :string
  end
end
