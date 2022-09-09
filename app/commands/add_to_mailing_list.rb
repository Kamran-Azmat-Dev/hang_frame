class AddToMailingList
  def call(email:)
    verify_configuration!
    verify_email!(email)
    add_to_mailing_list(email)
  end

  private

  def verify_configuration!
    raise 'Missing public key' unless ENV['KLAVIYO_PUBLIC_API_KEY'].present?
    raise 'Missing private key' unless ENV['KLAVIYO_PRIVATE_API_KEY'].present?
    raise 'Missing list id' unless list_id.present?
  end

  def verify_email!(email)
    raise 'Invalid email' unless email.present?
  end

  def add_to_mailing_list(email)
    Klaviyo::Lists.add_subscribers_to_list(
      list_id,
      profiles: [
        {
          email: email
        }
      ]
    )
  end

  def list_id
    ENV['KLAVIYO_LIST_ID']
  end
end
