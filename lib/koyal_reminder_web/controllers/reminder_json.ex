defmodule KoyalReminderWeb.ReminderJSON do
  alias KoyalReminder.Reminders.Reminder

  @doc """
  Renders a list of reminders.
  """
  def index(%{reminders: reminders}) do
    %{data: for(reminder <- reminders, do: data(reminder))}
  end

  @doc """
  Renders a single reminder.
  """
  def show(%{reminder: reminder}) do
    %{data: data(reminder)}
  end

  defp data(%Reminder{} = reminder) do
    %{
      id: reminder.id,
      title: reminder.title,
      description: reminder.description,
      time: reminder.time,
      location: reminder.location,
      user_id: reminder.user_id
    }
  end
end
