defmodule BambooCompany.Emails.Email do
  import Bamboo.Email

  def send_new_listing_email(%{"email_address" => email_address, "company_name" => company_name, "category" => category}) do
    new_email()
    |> to(email_address)
    |> from("bamboostocks@gmail.com")
    |> subject("New company Listed in your Subscribed Category - #{category}")
    |> html_body("You can now buy stocks from #{company_name} which has just been listed")
    |> text_body("You can now buy stocks from #{company_name} which has just been listed")
  end
end
