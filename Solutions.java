
public class Solutions {

    public static String reverseWords(String str1, String str2) {
        String[] words = str1.split("\\s");
        int idx = -1;
        for (int i = 0; i < words.length; i++) {
            if (words[i].contains(str2)) {
                idx = i;
                break;
            }

        }
        int endIdx = words.length - 1;
        while (idx < endIdx) {
            String temp = words[idx];
            words[idx] = words[endIdx];
            words[endIdx] = temp;
            idx++;
            endIdx--;
        }
        return String.join(" ", words);

    }

    public static void main(String[] args) {
        String result = reverseWords("This is a test String only", "st");
        System.out.println(result);

    }
}
