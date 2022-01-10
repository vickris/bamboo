defmodule BambooCompanyWeb.ListingsChannelTest do
  use BambooCompanyWeb.ChannelCase
  @body %{"body" => %{"company_name" => "Some Name", "category" => "Some Category"}}
  setup do
    {:ok, _, socket} =
      BambooCompanyWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(BambooCompanyWeb.ListingsChannel, "listings:new")

    %{socket: socket}
  end

  test "new listings broadcasts to new_listing", %{socket: socket} do
    push socket, "new_listing", @body
    assert_broadcast "new_listing", _payload
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    payload = @body["body"]
    broadcast_from! socket, "broadcast", payload
    assert_push "broadcast", _payload
  end
end
