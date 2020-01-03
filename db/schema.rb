# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_03_094952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_invitation_application_permissions", id: :serial, force: :cascade do |t|
    t.integer "batch_invitation_id", null: false
    t.integer "supported_permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_invitation_id", "supported_permission_id"], name: "index_batch_invite_app_perms_on_batch_invite_and_supported_perm", unique: true
  end

  create_table "batch_invitation_users", id: :serial, force: :cascade do |t|
    t.integer "batch_invitation_id"
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "outcome", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_invitation_id"], name: "index_batch_invitation_users_on_batch_invitation_id"
  end

  create_table "batch_invitations", id: :serial, force: :cascade do |t|
    t.text "applications_and_permissions"
    t.string "outcome", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "organisation_id"
    t.index ["outcome"], name: "index_batch_invitations_on_outcome"
  end

  create_table "event_logs", id: :serial, force: :cascade do |t|
    t.string "uid", limit: 255, null: false
    t.datetime "created_at", null: false
    t.integer "initiator_id"
    t.integer "application_id"
    t.string "trailing_message", limit: 255
    t.integer "event_id"
    t.index ["uid", "created_at"], name: "index_event_logs_on_uid_and_created_at"
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.integer "expires_in", null: false
    t.string "redirect_uri", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", limit: 255
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.string "refresh_token", limit: 255
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes", limit: 255
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "uid", limit: 255, null: false
    t.string "secret", limit: 255, null: false
    t.string "redirect_uri", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "home_uri", limit: 255
    t.string "description", limit: 255
    t.boolean "supports_push_updates", default: true
    t.boolean "retired", default: false
    t.boolean "confidential", default: true, null: false
    t.index ["name"], name: "unique_application_name", unique: true
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "old_passwords", id: :serial, force: :cascade do |t|
    t.string "encrypted_password", limit: 255, null: false
    t.string "password_salt", limit: 255
    t.integer "password_archivable_id", null: false
    t.string "password_archivable_type", limit: 255, null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "organisations", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "organisation_type", limit: 255, null: false
    t.string "abbreviation", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry", limit: 255
    t.string "content_id", limit: 255, null: false
    t.boolean "closed", default: false
    t.index ["ancestry"], name: "index_organisations_on_ancestry"
    t.index ["content_id"], name: "index_organisations_on_content_id", unique: true
    t.index ["slug"], name: "index_organisations_on_slug", unique: true
  end

  create_table "supported_permissions", id: :serial, force: :cascade do |t|
    t.integer "application_id"
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delegatable", default: false
    t.boolean "grantable_from_ui", default: true, null: false
    t.index ["application_id", "name"], name: "index_supported_permissions_on_application_id_and_name", unique: true
    t.index ["application_id"], name: "index_supported_permissions_on_application_id"
  end

  create_table "user_application_permissions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "application_id", null: false
    t.integer "supported_permission_id", null: false
    t.datetime "last_synced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "application_id", "supported_permission_id"], name: "index_app_permissions_on_user_and_app_and_supported_permission", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: ""
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uid", limit: 255, null: false
    t.integer "failed_attempts", default: 0
    t.datetime "locked_at"
    t.datetime "suspended_at"
    t.string "invitation_token", limit: 255
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type", limit: 255
    t.string "reason_for_suspension", limit: 255
    t.string "password_salt", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.string "role", limit: 255, default: "normal"
    t.datetime "password_changed_at"
    t.integer "organisation_id"
    t.boolean "api_user", default: false, null: false
    t.datetime "unsuspended_at"
    t.datetime "invitation_created_at"
    t.string "otp_secret_key", limit: 255
    t.integer "second_factor_attempts_count", default: 0
    t.boolean "require_2sv", default: false, null: false
    t.string "unlock_token", limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["organisation_id"], name: "index_users_on_organisation_id"
    t.index ["otp_secret_key"], name: "index_users_on_otp_secret_key", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
