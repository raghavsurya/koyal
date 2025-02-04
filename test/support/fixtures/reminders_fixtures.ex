defmodule KoyalReminder.RemindersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KoyalReminder.Reminders` context.
  """

  @doc """
  Generate a reminder.
  """
  def reminder_fixture(attrs \\ %{}) do
    {:ok, reminder} =
      attrs
      |> Enum.into(%{
        description: "some description",
        location: "some location",
        time: ~U[2025-02-03 23:10:00Z],
        title: "some title",
        user_id: 42
      })
      |> KoyalReminder.Reminders.create_reminder()

    reminder
  end
end
