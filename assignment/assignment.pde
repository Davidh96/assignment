void setup()
{
  size(500,500); 
  loadData();
}

//This array list is of type SortLists which will be used to hold all my data
ArrayList<SortLists> dlist =new ArrayList<SortLists>();

//This method loads the data from the .csv file in the data folder and sorts it by encapsulating using a class called SortLists
void loadData()
{
   //Load the data from my .csv file int the sketch
   String[] lines=loadStrings("drug_alcohol_deaths.csv");
   
   for(int i=1;i<lines.length-1;i++)
   {  
     //Split the string where a "," is found
      String[] data=lines[i].split(",");
      
      //Creates a SortList called perCounty. My data will be passed to the method SortLists and sort it for later use and place it in perCounty
      SortLists perCounty= new SortLists(data);
      //For every loop the perCounty is added to my dlist
      dlist.add(perCounty); 
   }
 
}


