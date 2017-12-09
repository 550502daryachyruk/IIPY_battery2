require 'green_shoes'
def gui
  Shoes.app title: 'Battery', width: 450, height: 120 do
    $battety_line = edit_line width: 400, margin: 10
    $line = edit_line width: 60, margin: 10
    $button = button 'Input time', margin: 10
    $line2 = edit_line width: 120, margin: 10
    $button2 = button 'Get time', margin: 10
    Thread.new do
      text = `acpi`.delete("\n")
      $battety_line.text = text
      sleep 1
    end
    $button.click do
      i = $line.text
      `gsettings set org.gnome.desktop.session idle-delay #{i}`
    end
    $button2.click do
      $line2.text = `gsettings get org.gnome.desktop.session idle-delay`.split(' ').last
    end
  end
end

time = `gsettings get org.gnome.desktop.session idle-delay`
time = time.split(' ').last
gui
`gsettings set org.gnome.desktop.session idle-delay #{time}`
