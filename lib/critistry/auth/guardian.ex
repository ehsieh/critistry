defmodule Critistry.Auth.Guardian do
    use Guardian, otp_app: :critistry    
  
    def subject_for_token(email, _claims) do
      IO.puts "subject_for_token #{email}"
      {:ok, to_string(email)}
    end
  
    def resource_from_claims(%{"sub" => email}) do
        IO.puts "resource_from_claims #{email}"
        {:ok, email}
    end
  end