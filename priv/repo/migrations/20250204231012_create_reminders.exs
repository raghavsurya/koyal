defmodule KoyalReminder.Repo.Migrations.CreateReminders do
  use Ecto.Migration

  def change do
    create table(:reminders) do
      add :title, :string
      add :description, :text
      add :time, :utc_datetime
      add :location, :string
      add :user_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
