defmodule KoyalReminder.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KoyalReminder.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        description: "some description",
        location: "some location",
        time: ~U[2025-02-03 23:08:00Z],
        title: "some title",
        user_id: 42
      })
      |> KoyalReminder.Users.create_user()

    user
  end
end
