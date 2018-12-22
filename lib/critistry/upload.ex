defmodule Critistry.Upload do
  def upload_image(image) do
    file_uuid = UUID.uuid4(:hex)        
    image_filename = image.filename
    unique_filename = "#{file_uuid}-#{image_filename}"
    {:ok, image_binary} = File.read(image.path)           
    bucket_name = System.get_env("BUCKET_NAME")

    result = 
      ExAws.S3.put_object(bucket_name, unique_filename, image_binary)          
      |> ExAws.request!

    IO.inspect result

    "https://s3-us-west-1.amazonaws.com/#{bucket_name}/#{bucket_name}/#{unique_filename}"
  end
end