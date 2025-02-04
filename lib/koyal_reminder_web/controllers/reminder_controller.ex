defmodule KoyalReminderWeb.ReminderController do
  use KoyalReminderWeb, :controller

  alias KoyalReminder.Reminders
  alias KoyalReminder.Reminders.Reminder

  action_fallback KoyalReminderWeb.FallbackController

  def index(conn, _params) do
    reminders = Reminders.list_reminders()
    render(conn, :index, reminders: reminders)
  end

  def create(conn, %{"reminder" => reminder_params}) do
    IO.inspect(reminder_params)
    with {:ok, %Reminder{} = reminder} <- Reminders.create_reminder(reminder_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/reminders/#{reminder}")
      |> render(:show, reminder: reminder)
    end
  end

  def show(conn, %{"id" => id}) do
    reminder = Reminders.get_reminder!(id)
    render(conn, :show, reminder: reminder)
  end

  def update(conn, %{"id" => id, "reminder" => reminder_params}) do
    reminder = Reminders.get_reminder!(id)

    with {:ok, %Reminder{} = reminder} <- Reminders.update_reminder(reminder, reminder_params) do
      render(conn, :show, reminder: reminder)
    end
  end

  def delete(conn, %{"id" => id}) do
    reminder = Reminders.get_reminder!(id)

    with {:ok, %Reminder{}} <- Reminders.delete_reminder(reminder) do
      send_resp(conn, :no_content, "")
    end
  end
end
