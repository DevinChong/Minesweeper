public class Dashboard
{
    private MSButton face;

    public Dashboard()
    {
        face = new MSButton((width / 2) - 22, height - 50);
        face.setLabel("🙂");
    }

    public void setLabel(String label)
    {
        face.setLabel(label);
    }

    public void draw() {
        fill(45);
        rect(5, height - 50, width - 10, 45, 5); 
        fill(255);
        textSize(25);
        if (status == 1) {
            text("🚩 " + flagsLeft, width / 4, height - 32.5);
            text("⏱ " + flagsLeft, width * 3 / 4, height - 32.5);
        } else if (status == 2)
            face.setLabel("😖");
        else if (status == 3)
            face.setLabel("😎");
    }

}