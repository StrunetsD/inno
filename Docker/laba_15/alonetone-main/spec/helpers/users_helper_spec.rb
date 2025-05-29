# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  it "returns request path for a missing avatar image" do
    expect(UsersHelper.no_avatar_path).to eq('default/no-pic_white.svg')
  end

  it "formats location for a user without profile" do
    expect(user_location(nil)).to be_blank
  end

  it "formats location for a user with a profile" do
    expect(user_location(profiles(:jamie_kiesl))).to eq('from Wilwaukee, US')
    expect(user_location(profiles(:will_studd))).to eq('from AU')
    expect(user_location(profiles(:henri_willig))).to eq('from Edam')
    expect(user_location(profiles(:william_shatner))).to eq('')
  end

  it "formats a summary for a missing user" do
    expect(user_summary(nil)).to be_blank
  end

  it "format summary for a user" do
    user = users(:jamie_kiesl)
    date = user.created_at.to_date.to_s(:long)
    profile = <<~PROFILE
      jamiek
      Joined alonetone #{date}
      from Wilwaukee, US
    PROFILE
    expect(user_summary(user)).to eq(profile.strip)

    user = users(:will_studd)
    date = user.created_at.to_date.to_s(:long)
    profile = <<~PROFILE
      willstudd
      4 uploaded tracks
      Joined alonetone #{date}
      from AU
    PROFILE
    expect(user_summary(user)).to eq(profile.strip)

    user = users(:henri_willig)
    date = user.created_at.to_date.to_s(:long)
    profile = <<~PROFILE
      Henri Willig
      2 uploaded tracks
      Joined alonetone #{date}
      from Edam
    PROFILE
    expect(user_summary(user)).to eq(profile.strip)

    user = users(:william_shatner)
    date = user.created_at.to_date.to_s(:long)
    profile = <<~PROFILE
      Captain Bill
      Joined alonetone #{date}
    PROFILE
    expect(user_summary(user)).to eq(profile.strip)
  end

  it "renders image link " do
    element = user_image_link(nil, variant: :large_avatar)
    expect(element).to include(UsersHelper.no_avatar_path)
  end

  context "no user" do
    it "formats a default avatar URL" do
      expect(user_avatar_url(nil, variant: :album)).to eq(UsersHelper.no_avatar_path)
    end

    it "formats an image element" do
      element = user_image(nil, variant: :large_avatar)
      expect(element).to match_css('img[class="no_border"][src]')
      expect(element).to include(UsersHelper.no_avatar_path)
    end

    it "formats a placeholder instead of link" do
      element = white_theme_user_image_link(nil, variant: :small)
      expect(element).to_not match_css('a')
      expect(element).to match_css('img[class="no_border"][src]')
      expect(element).to include(UsersHelper.no_avatar_path)
    end
  end

  context "user with an avatar" do
    let(:user) { users(:henri_willig) }
    let(:base_url) { 'http://alonetone.example.com' }

    around do |example|
      with_storage_current_host(base_url) do
        example.call
      end
    end

    it "formats an avatar URL" do
      url = user_avatar_url(user, variant: :large_avatar)
      expect(url).to include(base_url)
      expect(url).to end_with('.jpg')
    end

    it "formats an image element" do
      element = user_image(user, variant: :large_avatar)
      expect(element).to match_css('img[src][alt="Henri Willig\'s avatar"]')
      expect(element).to match_css('img:not([class])')
      expect(element).to include(base_url)
    end

    it "formats a link with a user avatar" do
      element = white_theme_user_image_link(user, variant: :small_avatar)
      expect(element).to match_css('a > img[src]')
      expect(element).to include(base_url)
    end
  end

  context "user without an avatar" do
    let(:user) { users(:william_shatner) }

    it "formats a default avatar URL" do
      expect(user_avatar_url(user, variant: :album)).to eq(UsersHelper.no_avatar_path)
    end

    it "formats an image element" do
      element = user_image(user, variant: :large_avatar)
      expect(element).to match_css('img[class="no_border"][src]')
      expect(element).to include(UsersHelper.no_avatar_path)
    end

    it "formats a placeholder instead of link" do
      element = white_theme_user_image_link(user, variant: :tiny)
      expect(element).to match_css('a > img[class="no_border"][src]')
      expect(element).to include(UsersHelper.no_avatar_path)
    end

    it "actually has the default avatar on disk" do
      expect(Rails.application.assets.find_asset(UsersHelper.no_avatar_path)).to_not be_nil
    end
  end
end
