module TokenAuthSupport
  def valid_token
    User.last.authorisations.first
  end

  def expired_token
    token = valid_token
    token.update_column(:created_at, 3.days.ago)
    token.update_column(:expires_in, 30)
    token
  end

  def revoked_token
    valid_token.tap(&:revoke)
  end
end
