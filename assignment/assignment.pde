void setup()
{
  size(500,500); 
  loadData();
}

ArrayList<ArrayList<Float>> deathtotal=new ArrayList<ArrayList<Float>>();

//This method loads the data from the .csv file in the data folder
void loadData()
{
   String[] lines=loadStrings("drug_alcohol_deaths.csv");
   
   for(String l:lines)
   {
      
     //Split the string where a "," is found
      String[] data=l.split(",");
      
      //Create a new array list called 'death' for every loop
      ArrayList<Float> death=new ArrayList<Float>();
      
      for(int i=1;i<data.length;i++)
      {
          //Add the numbers to 'death' and exclude the county names for now
          death.add(Float.parseFloat(data[i]));
      }
      
      deathtotal.add(death);
   }
   
   println(deathtotal);
}
