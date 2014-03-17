public class componentController {
    public String selectedValue {
        get;
        set {
            editMode = (value != null);
            selectedValue = value;
        }
    }
    
    public Boolean editMode {
        get; private set;
    }
}