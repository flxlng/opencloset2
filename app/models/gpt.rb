class Gpt
  # def gpt_description
  #   Gpt.gpt_call("Please describe the following thing:", cloudinary_public_id)
  # end


  def self.gpt_call(prompt, file_url = nil)
    client = OpenAI::Client.new

    # if file_url
    #   file_content = open(file_url).read
    #   prompt += "\n\nFile Content:\n#{file_content}"
    # end

    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o",
      messages: [
        {
          role: "user",
          content: [
            {
              type: "text",
              text: prompt,
            },
            {
              type: "image_url",
              image_url: {
                url: "https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg"
              }
            }
          ]
        }
      ],
      max_tokens: 300
    })

    chatgpt_response["choices"][0]["message"]["content"]
  end
end
