defmodule LiveExamples.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LiveExamples.Repo,
      # Start the Telemetry supervisor
      LiveExamplesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveExamples.PubSub},
      # Start the Endpoint (http/https)
      LiveExamplesWeb.Endpoint
      # Start a worker by calling: LiveExamples.Worker.start_link(arg)
      # {LiveExamples.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveExamples.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveExamplesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
