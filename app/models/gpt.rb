class Gpt
  def self.gpt_call(prompt, file_url = nil)
    client = OpenAI::Client.new

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
                url: file_url
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
