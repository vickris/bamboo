defmodule BambooCompany.QueryingService do
  use Task

  def start_link(_arg) do
    Task.start_link(&poll/0)
  end

  # Assumption is Am doing querying based off some timestamp Value I have
  # Periodically.
  def poll() do
    receive do
      after
        Application.get_env(:bamboo_company, :polling_time) ->
          # Here Is Where We query the external service
          IO.puts("We are now making the call to our stocks provider")
          poll()
    end
  end

end
