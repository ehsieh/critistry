defmodule Critistry.Auth.Guardian do
    use Guardian, otp_app: :critistry    
  
    def subject_for_token(email, _claims) do
      IO.puts "subject_for_token #{email}"
      {:ok, to_string(email)}
    end
  
    def resource_from_claims(%{"sub" => email}) do
        IO.puts "resource_from_claims"
        user = Critistry.Auth.find_user_by_email(email)
        IO.inspect user     
        case user do
          nil -> {:error, nil}
          _user -> {:ok, user}          
          end
    end
  end