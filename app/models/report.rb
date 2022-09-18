class Report < ApplicationRecord
  has_one_attached :file


  def self.generate_report
    report = Report.create
    file_name = "Report-#{Date.today}"
    @parcels = Parcel.includes(:sender, :receiver, :service_type)

    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(name: file_name) do |sheet|
      sheet.add_row %w(id order_id weight	status	service_type	payment_mode sender receiver)
      @parcels.each do |parcel|
        create_row(sheet, parcel)
      end
    end
    p.serialize "tmp/#{file_name}.xlsx"
    report.file.attach(io: File.open("tmp/#{file_name}.xlsx"), filename: file_name)
  end

  def self.create_row(sheet, parcel)
    sheet.add_row [ parcel.id, 
                    parcel.guid, 
                    parcel.weight,
                    parcel.status, 
                    parcel.service_type.name, 
                    parcel.payment_mode, 
                    parcel.sender.name, 
                    parcel.receiver.name
                  ]
  end
end
