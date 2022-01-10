defmodule BambooCompany.EmailService do
  alias BambooCompany.Emails.{Mailer, Email}
  alias BambooCompany.Repo

  def send_email(company) do
    category = company.category |> Repo.preload(:users)
    subscribed_users = category.users

    subscribed_users
    |> Enum.each(fn user ->
      %{"email_address" => user.email, "company_name" => company.name, "category" => category.name}
      |> Email.send_new_listing_email()
      |> Mailer.deliver_now()
    end)
  end
end
