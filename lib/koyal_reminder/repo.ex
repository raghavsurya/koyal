defmodule KoyalReminder.Repo do
  use Ecto.Repo,
    otp_app: :koyal_reminder,
    adapter: Ecto.Adapters.Postgres
end
