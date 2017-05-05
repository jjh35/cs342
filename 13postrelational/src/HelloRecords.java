/**
 * Created by jjh35 on 5/5/2017.
 */
import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

public class HelloRecords {

    public HelloRecords()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        //create
        String movieIdString = "92616";
        String fieldName1 = "name";
        String fieldName2 = "year";
        String fieldName3 = "rating";
        Key key1= Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName1));
        Key key2 = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName2));
        Key key3 = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName3));

        String name = "Dr. Strangelove";
        Value value1 = Value.createValue(name.getBytes());
        store.put(key1, value1);

        String year = "1964";
        Value value2 = Value.createValue(year.getBytes());
        store.put(key2,value2);

        String rating = "8.7";
        Value value3 = Value.createValue(rating.getBytes());
        store.put(key3,value3);


        //Read
        String result = new String(store.get(key1).getValue().getValue());
        System.out.println(key1.toString() + " : " + result);
        result = new String(store.get(key2).getValue().getValue());
        System.out.println(key2.toString() + " : " + result);
        result = new String(store.get(key3).getValue().getValue());
        System.out.println(key3.toString() + " : " + result);

        System.out.println("multi-valued gets");

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", movieIdString));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }

        store.delete(key1);
        if (store.get(key1) == null) {
            System.out.println("Good, key1 successfully deleted...");
        } else {
            System.out.println("Oops, key1 not deleted...");
        }

        store.delete(key2);
        if (store.get(key2) == null) {
            System.out.println("Good, key2 successfully deleted...");
        } else {
            System.out.println("Oops, key2 not deleted...");
        }

        store.delete(key3);
        if (store.get(key3) == null) {
            System.out.println("Good, key3 successfully deleted...");
        } else {
            System.out.println("Oops, key3 not deleted...");
        }

        store.close();
    }
}
