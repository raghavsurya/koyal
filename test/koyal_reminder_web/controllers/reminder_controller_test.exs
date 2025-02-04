defmodule KoyalReminderWeb.ReminderControllerTest do
  use KoyalReminderWeb.ConnCase

  import KoyalReminder.RemindersFixtures

  alias KoyalReminder.Reminders.Reminder

  @create_attrs %{
    time: ~U[2025-02-03 23:10:00Z],
    description: "some description",
    title: "some title",
    location: "some location",
    user_id: 42
  }
  @update_attrs %{
    time: ~U[2025-02-04 23:10:00Z],
    description: "some updated description",
    title: "some updated title",
    location: "some updated location",
    user_id: 43
  }
  @invalid_attrs %{time: nil, description: nil, title: nil, location: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reminders", %{conn: conn} do
      conn = get(conn, ~p"/api/reminders")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reminder" do
    test "renders reminder when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/reminders", reminder: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/reminders/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "location" => "some location",
               "time" => "2025-02-03T23:10:00Z",
               "title" => "some title",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/reminders", reminder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reminder" do
    setup [:create_reminder]

    test "renders reminder when data is valid", %{conn: conn, reminder: %Reminder{id: id} = reminder} do
      conn = put(conn, ~p"/api/reminders/#{reminder}", reminder: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/reminders/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "location" => "some updated location",
               "time" => "2025-02-04T23:10:00Z",
               "title" => "some updated title",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, reminder: reminder} do
      conn = put(conn, ~p"/api/reminders/#{reminder}", reminder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reminder" do
    setup [:create_reminder]

    test "deletes chosen reminder", %{conn: conn, reminder: reminder} do
      conn = delete(conn, ~p"/api/reminders/#{reminder}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/reminders/#{reminder}")
      end
    end
  end

  defp create_reminder(_) do
    reminder = reminder_fixture()
    %{reminder: reminder}
  end
end
