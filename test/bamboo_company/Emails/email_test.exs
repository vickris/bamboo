defmodule BambooCompany.Emails.EmailTest do
  use ExUnit.Case
  alias BambooCompany.Emails.{Mailer, Email}

  test "new listing email" do
    details = %{"email_address" => "chris@gmail.com", "company_name" => "company X", "category" => "Y"}

    email = details |> Email.send_new_listing_email()

    assert email.to == "chris@gmail.com"
    assert email.subject == "New company Listed in your Subscribed Category - Y"
    assert email.html_body =~ "You can now buy stocks from company X which has just been listed"
  end
end
