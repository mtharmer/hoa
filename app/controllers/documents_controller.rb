# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: %i[create destroy]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/download/1
  def download
    file = document.file
    if file.attached?
      send_data file.download, filename: file.filename.to_s, type: file.content_type,
                               disposition: 'attachment'
    else
      redirect_to documents_path, alert: I18n.t('documents.download.alert')
    end
  end

  # POST /documents or /documents.json
  def create
    document = Document.new(document_params)

    respond_to do |format|
      if document.save
        format.html { redirect_to document, notice: I18n.t('documents.create.notice') }
        format.json { render :show, status: :created, location: document }
      else
        format.html { redirect_to documents_path, status: :unprocessable_entity }
        format.json { render json: document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    attachment = document.file
    attachment.purge if attachment.attached?
    document.destroy!

    respond_to do |format|
      format.html { redirect_to documents_path, status: :see_other, notice: I18n.t('documents.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Memoize the document lookup to avoid multiple database queries.
  def document
    @document ||= Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:file)
  end
end
