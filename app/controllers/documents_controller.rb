# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[download destroy]
  before_action :authenticate_user!
  before_action :verify_admin, only: %i[create destroy]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  def download
    file = @document.file
    if file.attached?
      send_data file.download, filename: file.filename.to_s, type: file.content_type,
                               disposition: 'attachment'
    else
      redirect_to documents_path, alert: I18n.t('documents.download.alert')
    end
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params).sanitize

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: I18n.t('documents.create.notice') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { redirect_to documents_path, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.purge_file
    super(@document, documents_path) # Calls the destroy method from ApplicationController
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:file)
  end
end
