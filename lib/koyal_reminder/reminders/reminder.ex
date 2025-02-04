defmodule KoyalReminder.Reminders.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reminders" do
    field :time, :utc_datetime
    field :description, :string
    field :title, :string
    field :location, :string
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, [:title, :description, :time, :location, :user_id])
    |> validate_required([:title, :description, :time, :location, :user_id])
  end
end
