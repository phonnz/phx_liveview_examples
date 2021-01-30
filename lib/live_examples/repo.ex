defmodule LiveExamples.Repo do
  use Ecto.Repo,
    otp_app: :live_examples,
    adapter: Ecto.Adapters.Postgres
end
