defmodule BambooCompanyWeb.ListingsChannel do
  alias BambooCompany.Listings
  alias BambooCompany.EmailService
  use Phoenix.Channel
  require Logger

  def join("listings:new", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_listing", %{"body" => body}, socket) do
    # Assumption is that the info we get from our stock market
    # provider had both the company name and category
    case Listings.insert_company(body) do
      {:ok, company} ->
        EmailService.send_email(company)
        broadcast!(socket, "new_listing", %{body: body})
      {:error, changeset} -> Logger.info("Something went wrong during company creation. Supplied params #{inspect(changeset)}")
    end

    {:noreply, socket}
  end

end
