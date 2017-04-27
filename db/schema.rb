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

ActiveRecord::Schema.define(version: 20170423004811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "sims_tba_esq_secao_id"
    t.text     "obs"
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["person_id"], name: "index_appointments_on_person_id", using: :btree
  end

  create_table "assistent_appointments", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "appointment_id"
    t.text     "obs"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["appointment_id"], name: "index_assistent_appointments_on_appointment_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "nome_fantasia"
    t.string   "razao_social"
    t.string   "cnpj",          limit: 14
    t.string   "logradouro"
    t.string   "numero"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "estado",        limit: 2
    t.string   "telefone"
    t.string   "cep",           limit: 8
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["cnpj"], name: "index_companies_on_cnpj", unique: true, using: :btree
  end

  create_table "equipment", force: :cascade do |t|
    t.text     "nomeclatura"
    t.string   "sigla"
    t.integer  "appointment_id"
    t.integer  "account_id"
    t.integer  "kind_id"
    t.integer  "qtde"
    t.string   "bmp"
    t.string   "n_serie"
    t.string   "n_pn"
    t.decimal  "valor_atualizado"
    t.integer  "situation_id"
    t.integer  "status",           default: 0
    t.text     "obs"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["account_id"], name: "index_equipment_on_account_id", using: :btree
    t.index ["appointment_id"], name: "index_equipment_on_appointment_id", using: :btree
    t.index ["kind_id"], name: "index_equipment_on_kind_id", using: :btree
    t.index ["situation_id"], name: "index_equipment_on_situation_id", using: :btree
  end

  create_table "especifications", force: :cascade do |t|
    t.text     "descricao"
    t.integer  "type_id"
    t.integer  "qtde"
    t.decimal  "valor_un"
    t.integer  "modality_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "interest_id"
    t.index ["interest_id"], name: "index_especifications_on_interest_id", using: :btree
    t.index ["modality_id"], name: "index_especifications_on_modality_id", using: :btree
    t.index ["type_id"], name: "index_especifications_on_type_id", using: :btree
  end

  create_table "interests", force: :cascade do |t|
    t.string   "n_empenho"
    t.string   "aplicacao"
    t.string   "rsrp"
    t.text     "obs"
    t.string   "pregao"
    t.integer  "company_id"
    t.datetime "emissao"
    t.string   "processo"
    t.integer  "sims_squad_id"
    t.datetime "data_envio"
    t.datetime "prazo"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_cadastro"
    t.integer  "user_atualiza"
    t.index ["company_id"], name: "index_interests_on_company_id", using: :btree
  end

  create_table "kinds", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "person_id"
    t.text     "obs"
    t.datetime "data_saida"
    t.datetime "data_devolucao"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "appointment_id"
    t.integer  "status2",             default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["appointment_id"], name: "index_loans_on_appointment_id", using: :btree
    t.index ["user_id"], name: "index_loans_on_user_id", using: :btree
  end

  create_table "modalities", force: :cascade do |t|
    t.string   "nome"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "loan_id",                   null: false
    t.string   "nome",         default: "", null: false
    t.text     "descricao",    default: "", null: false
    t.integer  "qtde",                      null: false
    t.integer  "situation_id",              null: false
    t.integer  "user_id",                   null: false
    t.text     "obs"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["loan_id"], name: "index_products_on_loan_id", using: :btree
    t.index ["situation_id"], name: "index_products_on_situation_id", using: :btree
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "situations", force: :cascade do |t|
    t.string   "nome"
    t.string   "legenda"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "nome"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role",                   default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "assistent_appointments", "appointments"
  add_foreign_key "equipment", "accounts"
  add_foreign_key "equipment", "appointments"
  add_foreign_key "equipment", "kinds"
  add_foreign_key "equipment", "situations"
  add_foreign_key "especifications", "interests"
  add_foreign_key "especifications", "modalities"
  add_foreign_key "especifications", "types"
  add_foreign_key "interests", "companies"
  add_foreign_key "loans", "appointments"
  add_foreign_key "loans", "users"
  add_foreign_key "products", "loans"
  add_foreign_key "products", "situations"
  add_foreign_key "products", "users"
end
