import javax.swing.*;
import java.awt.*;

public class Joe extends JDialog {
    private JButton signInButton;
    private JTextField textField1;
    private JTextField textField2;
    private JPasswordField passwordField1;

    public Joe(JFrame parent)
    {
        super(parent);
        setTitle("Login");
        setMaximumSize( new Dimension(450 , 474));
        setModal(true);
        setLocationRelativeTo(parent);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setVisible(true);
    }

    public static void main(String [] args){
        Joe joe = new Joe(null);
    }

}
