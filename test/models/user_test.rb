require 'test_helper'
#tests are here as example pieces of code, they arent necessarily designed to
#make sense, merely to test whether in fact our actual model code/contr code
#is operating as it should do
class UserTest < ActiveSupport::TestCase

  def setup
    #this sets up all tests with the appropriate inputs to be able to run
    #effective tests, it generates the instance var further tests use
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobaruser", password_confirmation: "foobaruser")
    # added the password: and password_confirmation: guidelines in order to pass
    # imposed strictures implaced by our use of has_secure_password in user.rb
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_USER-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
    # The method here is to make a user with the same email address as
    # @user using @user.dup, which creates a duplicate user with the same
    # attributes. Since we then save @user, the duplicate user has an email
    # address that already exists in the database, and hence should not be valid.
    # refer to regexsimpleguide.md for more ways to understand
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "" * 10
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 9
    assert_not @user.valid?
  end

end
