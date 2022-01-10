defmodule BambooCompany.Repo do
  use Ecto.Repo,
    otp_app: :bamboo_company,
    adapter: Ecto.Adapters.Postgres
end
