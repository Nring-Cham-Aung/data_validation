


## Getting started

**Add package**

```
flutter pub add data_validation
```



## Usage


### Single validation
``` 
final result = SingleValidation(yourData, Validation.string().only(['Male', 'Female'])).validate();
```

```
final result = SingleValidation(yourData, Validation.email().mustEnd(['.com','.org'])).validate();
```

### Multi validation

```
final result = MultiValidation(data, {
  'name': Validation.string().max(30),
  'gender': Validation.string().only(['Male', 'Female']),
  'age': Validation.integer().min(0).max(150),
  'address': Validation.string(nullAble: true).max(200),
  'email': Validation.email().mustEnd(['.com','.org'])
}).validate();
```

