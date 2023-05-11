public class DemoClass {
    public String hellostring;
    public DemoClass(){
        this('hello');
    }
    public DemoClass(string stringtodisplay){
        this.hellostring=stringtodisplay;
    }
    public void printoutput(){
        System.debug('display text :'+hellostring);
    }
}