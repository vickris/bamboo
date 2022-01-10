defmodule BambooCompany.QueryingService do
  use Task
  alias BambooCompany.Listings

  def start_link(_arg) do
    Task.start_link(__MODULE__, :poll, [])
  end

  # Assumption is Am doing querying based off some timestamp value I have
  # Periodically.
  def poll() do
    receive do
      after
        Application.get_env(:bamboo_company, :polling_time) |> String.to_integer ->
          # Here Is Where We query the external service
          IO.puts("We are now making the call to our stocks provider")
          response = [
            %{"company_name" => "company X", "category" => "category X"},
            %{"company_name" => "company Y", "category" => "category Y"},
            %{"company_name" => "company Z", "category" => "category X"},
          ]
          Listings.batch_insert(response)

          poll()
    end
  end

end
