defmodule BambooCompanyWeb.ListingsChannelTest do
  use BambooCompanyWeb.ChannelCase
  alias BambooCompany.Repo
  alias BambooCompany.Companies.Company

  @body %{"body" => %{"company_name" => "Some Name", "category" => "Some Category"}}

  setup do
    {:ok, _, socket} =
      BambooCompanyWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(BambooCompanyWeb.ListingsChannel, "listings:new")

    %{socket: socket}
  end

  test "new listings trigger broadcasts to new_listing subscribers", %{socket: socket} do
    push socket, "new_listing", @body
    assert_broadcast "new_listing", _payload
  end

  test "new listings are added to the DB", %{socket: socket} do
    initial_company_count = Repo.all(Company) |> Enum.count()
    assert initial_company_count == 0

    push socket, "new_listing", @body
    assert_broadcast "new_listing", _payload

    latest_company_count = Repo.all(Company) |> Enum.count()
    assert latest_company_count == 1
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    payload = @body["body"]
    broadcast_from! socket, "broadcast", payload
    assert_push "broadcast", _payload
  end
end
