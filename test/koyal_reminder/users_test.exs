defmodule KoyalReminder.UsersTest do
  use KoyalReminder.DataCase

  alias KoyalReminder.Users

  describe "users" do
    alias KoyalReminder.Users.User

    import KoyalReminder.UsersFixtures

    @invalid_attrs %{time: nil, description: nil, title: nil, location: nil, user_id: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{time: ~U[2025-02-03 23:08:00Z], description: "some description", title: "some title", location: "some location", user_id: 42}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.time == ~U[2025-02-03 23:08:00Z]
      assert user.description == "some description"
      assert user.title == "some title"
      assert user.location == "some location"
      assert user.user_id == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{time: ~U[2025-02-04 23:08:00Z], description: "some updated description", title: "some updated title", location: "some updated location", user_id: 43}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.time == ~U[2025-02-04 23:08:00Z]
      assert user.description == "some updated description"
      assert user.title == "some updated title"
      assert user.location == "some updated location"
      assert user.user_id == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
