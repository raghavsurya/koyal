defmodule KoyalReminder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KoyalReminderWeb.Telemetry,
      KoyalReminder.Repo,
      {DNSCluster, query: Application.get_env(:koyal_reminder, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KoyalReminder.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: KoyalReminder.Finch},
      # Start a worker by calling: KoyalReminder.Worker.start_link(arg)
      # {KoyalReminder.Worker, arg},
      # Start to serve requests, typically the last entry
      KoyalReminderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KoyalReminder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KoyalReminderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
