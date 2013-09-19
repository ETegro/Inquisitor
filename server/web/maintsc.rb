module Sticker

module Printers

class Maintsc < Abstracttsc

	def render(layout, copies)
		str = "SPEED 2\n
DENSITY 10\n
SET CUTTER OFF\n
SET PEEL OFF\n
SET TEAR ON\n
DIRECTION 0\n
SIZE 3.980,2.910\n
GAP 0.120,0.00\n
OFFSET 0\n
REFERENCE 0,20\n
CLS\n"

                step = 32
                textheight = 28
                x = 647
                low = 71
		char = 10
		lines = 20

		if header = layout.find { |el| el[:kind] == :single_record_block && el[:display] == 'computer-title-header' }
			str << "TEXT 790,40,\"3\",90,1,2,\"#{ header[:data]["name"] }\"\n
BARCODE 799,390,\"128M\",58,0,90,2,2,\"!105#{ header[:data]["serial_no"] }\"\n
TEXT 743,345,\"3\",90,1,1,\"S/N:#{ header[:data]["serial_no"] }\"\n
TEXT 743,40,\"3\",90,1,1,\"P/N:#{ header[:data]["order_code"] }\"\n
BAR #{low},63,#{x+2*step-low},3\n
BAR #{low},120,#{x+2*step-low},3\n
BAR #{low},522,#{x+2*step-low},3\n
BAR #{x+step},24,4,548\n"
		end

		if grid = layout.find { |el| el[:kind] == :grid }
			if grid[:head]
				str << "TEXT #{x+step+textheight},34,\"2\",90,1,1,\"#{ grid[:head][0] }\"\n
TEXT #{x+step+textheight},80,\"2\",90,1,1,\"#{ grid[:head][1] }\"\n
TEXT #{x+step+textheight},300,\"2\",90,1,1,\"#{ grid[:head][2] }\"\n
TEXT #{x+step+textheight},532,\"2\",90,1,1,\"#{ grid[:head][3] }\"\n
BAR #{x+2*step},24,4,548\n"
				lines -= 1
			end
			grid[:body].each do |row|
				break if lines == 0
				row = row.collect { |s| escape("#{ s }") }
				tx = x + textheight
				fmt = "%2s %-4s %-32s  %s"
				rs = sprintf(fmt, row[0], row[1], row[2][0..31], row[3])
				str << "TEXT #{tx},34,\"2\",90,1,1,\"#{ rs }\"\n"
				x -= step
				lines -=1
				leftover = row[2][32..-1]
				while leftover && !leftover.gsub(/\s*/, '').empty? && lines > 0
					tx = x + textheight
					rs = sprintf(fmt, '', '', leftover[0..31], '')
					str << "TEXT #{tx},34,\"2\",90,1,1,\"#{ rs }\"\n"
					x -= step
					lines -=1
					leftover = leftover[32..-1]
				end			
				str << "BAR #{x + step},24,2,548\n" if lines > 0
			end
		end

		if footer = layout.find { |el| el[:kind] == :single_record_block && el[:display] == 'manufacturing-date-footer' }
			qc = footer[:data]['checker_id']
			qc = qc ? sprintf("%02d", qc) : ''
			str << "BAR 69,24,3,549\n
BAR 18,440,54,3\n
TEXT 65,450,\"3\",90,1,1,\"Test OK\"\n
TEXT 38,450,\"3\",90,1,1,\"Check#{ qc }\"\n
TEXT 65,270,\"3\",90,1,1,\"#{ footer[:data]['manufacturing_date'] }\"\n
TEXT 38,270,\"3\",90,1,1,\"#{ footer[:data]['buyer_order_number'] }\"\n"
			str << File.open("#{ @assets }/bg-bottom.bmp").read
		end

		str << "PRINT #{copies},1\n"
		str
	end

end

end

end
	
