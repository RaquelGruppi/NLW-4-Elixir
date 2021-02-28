defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Ane",
        password: "123456",
        nickname: "ane",
        email: "ane@example.com",
        age: 29
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Ane", age: 29, id: ^user_id} = user
    end

    test "when params are invalid, returns an error" do
      params = %{
        name: "Ane",
        nickname: "ane",
        email: "ane@example.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response =  %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
