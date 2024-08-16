import json
import random
import string

class JSONManipulation:
    def add_random_alphabet_string_to_json(self, file_path, keys, length):
        length = int(length)  # Convert length to integer
        with open(file_path, 'r') as f:
            data = json.load(f)

        for key in keys:
            random_string = ''.join(random.choice(string.ascii_letters) for _ in range(length))  # Generate a random alphabetical string
            data[key] = random_string  # Update JSON data with the random string

        with open(file_path, 'w') as f:
            json.dump(data, f, indent=4)  # Write the updated data back to the JSON file
    
    def extract_json_value_to_array(self, response, array_name, variable_name):
        new_array = []
        try:
            response_dict = json.loads(response)
            response_array = response_dict.get(array_name, [])
            for response_value in response_array:
                new_value = response_value.get(variable_name)
                if new_value:
                    new_array.append(new_value)
        except json.JSONDecodeError:
            # Handle JSON decoding error
            pass
        return new_array
    ''' *****Below is the case of json format, when the above function can be used*****
      {
        "array_name": [
            {
                "variable_name": 245,
                "othervariable": "robo",
            },
            {
                "variable_name": 246,
                "othervariable": "robo1",
            } ]
        }
    '''


