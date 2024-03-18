<?php

return [
    'register' => [
        'hooks' => 'Identification,FormItSaveForm,FormItAutoResponder',
        'method' => 'register',
        'successMessage' => 'Вы успешно зарегистрированы. Подтвердите email для активации учётной записи.',

        'fiarSubject' => 'Активация пользователя',
        'fiarFrom' => 'email@domain.ru',
        'fiarTpl' => 'siActivateEmail',

        'activation' => 1,
        'rememberme' => 1,
        'authenticateContexts' => 'web',
        'afterLoginRedirectId' => 28,
        'autoLogin' => 1,
        'redirectTo' => '',
        'passwordField' => '',
        'usernameField' => 'email',
        'usergroupsField' => '',
        'moderate' => '',
        'redirectTimeout' => 3000,
        'usergroups' => 2,
        'activationResourceId' => 23,
        'activationUrlTime' => 10800,
        'validate' => 'email:email:required,phone:required,password:checkPassLength=^8^,password_confirm:passwordConfirm=^password^',
        'email.vTextRequired' => 'Укажите email.',
        'phone.vTextRequired' => 'Укажите телефон.',
        'email.vTextUserExists' => 'Этот email уже используется.',
        'password.vTextCheckPassLength' => 'Слишком короткий пароль.',
    ],
    'auth' => [
        'successMessage' => 'Вы успешно авторизованы и будете перенаправлены в личный кабинет.',
        'validate' => 'email:required,password:required',
        'hooks' => 'Identification',

        'method' => 'login',

        'redirectTo' => 27,
        'redirectTimeout' => 3000,
        'usernameField' => 'email',

        'email.vTextRequired' => 'Укажите email.',
        'password.vTextRequired' => 'Введите пароль.',
        'errorFieldName' => 'errorLogin'
    ],
    'forgot' => [
        'hooks' => 'Identification,FormItSaveForm,FormItAutoResponder',
        'method' => 'forgot',
        'successMessage' => 'Новый пароль отправлен на ваш email',

        'usernameField' => 'email',
        'validate' => 'email:required:userNotExists',

        'fiarSubject' => 'Восстановление пароля',
        'fiarFrom' => 'email@domain.ru',
        'fiarTpl' => 'siResetPassEmail',

        'email.vTextRequired' => 'Укажите email.',
        'email.vTextUserNotExists' => 'Пользователь не найден',
    ],
    'acceptoffer' => [
        'hooks' => 'Identification',
        'method' => 'update',
        'successMessage' => 'Оферта принята.',
        'clearFieldsOnSuccess' => 0,
        'validate' => 'offer:checkbox:required',
        'offer.vTextRequired' => 'Примите оферту.'
    ],
    'editpass' => [
        'hooks' => 'Identification',
        'method' => 'update',
        'successMessage' => 'Пароль изменён.',

        'validate' => 'password:required:minLength=^8^:regexp=^/\A[\da-zA-Z!#\?&]*$/^,password_confirm:password_confirm=^password^',

        'password.vTextRequired' => 'Придумайте пароль.',
        'password.vTextRegexp' => 'Пароль может содержать только цифры, латинские буквы и символы !,#,?,&',
        'password.vTextMinLength' => 'Пароль должен быть не менее 8 символов.',
    ],
    'add_avatar' => [
        'hooks' => 'PrepareUserFiles,Identification',
        'method' => 'update',
        'successMessage' => 'Фото сохранены.',
        'clearFieldsOnSuccess' => 0,
        'allowFiles' => 'photo'
    ],
    'get_avatar' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/designer/snippet.getuseravatar.php',
    ],
    'dataedit' => [
        'hooks' => 'PrepareUserFiles,Identification',
        'method' => 'update',
        'successMessage' => 'Данные сохранены.',
        'clearFieldsOnSuccess' => 0,
        'allowFiles' => 'extended[selfemployed_img],extended[pass_one_img],extended[pass_two_img],extended[insurance_img],extended[certificate_img],extended[inn_img]',
        'validate' => 'email:required:email,
        extended[surname]:required,
        extended[name]:required,
        extended[fathername]:required,
        phone:required,
        pass_series:required,
        pass_num:required,
        extended[pass_date]:required,
        extended[pass_code]:required,
        extended[pass_where]:required,
        extended[pass_address]:required,
        dob:required,
        legal_form:required,
        extended[certificate_num]:requiredIf=^legal_form|Самозанятый^,
        extended[certificate_date]:requiredIf=^legal_form|Самозанятый^,
        extended[insurance]:requiredIf=^legal_form|Самозанятый^,
        extended[selfemployed_img]:requiredIf=^legal_form|Самозанятый^,
        extended[address_ip]:requiredIf=^legal_form|ИП^,
        extended[ogrnip]:requiredIf=^legal_form|ИП^,
        extended[certificate_img]:checkbox:requiredIf=^legal_form|ИП^,
        inn:required,
        extended[rs]:required,
        extended[bik]:required,
        extended[card_data]:required,
        zip:required,
        address:required,
        zip_fact:required,
        address_fact:required',
    ],
    'upload_user_file' => [
        'hooks' => '',
        'maxSize' => 150,
        'maxCount' => 1,
        'allowExt' => 'jpg,png,jpeg,webp,tiff,tif',
        'portion' => 1,
        'threadsQuantity' => 12,
    ],
    'selfemployed_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'selfemployed_img',
        'allowFiles' => 'extended[selfemployed_img]',
    ],
    'pass_one_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'pass_one_img',
        'allowFiles' => 'extended[pass_one_img]',
    ],
    'pass_two_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'pass_two_img',
        'allowFiles' => 'extended[pass_two_img]',
    ],
    'insurance_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'insurance_img',
        'allowFiles' => 'extended[insurance_img]',
    ],
    'certificate_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'certificate_img',
        'allowFiles' => 'extended[certificate_img]',
    ],
    'inn_img' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'inn_img',
        'allowFiles' => 'extended[inn_img]',
    ],
    'user_photo' => [
        'extends' => 'upload_user_file',
        'attachFilesToEmail' => 'avatar',
        'allowFiles' => 'photo',
    ],
    'upload_quiz' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.createproduct.php',
        'clearFieldsOnSuccess' => 1,
    ],
    'upload_design' => [
        'hooks' => '',
        'maxSize' => 2000,
        'maxCount' => 3,
        'allowExt' => 'jpg,png,jpeg,webp,tiff,tif',
        'threadsQuantity' => 12,
        'portion' => 1,
    ],
    'search_tag' => [
        'tplChar' => '@FILE chunks/gettagsbyalphabet/char.tpl',
        'tplTag' => '@FILE chunks/gettagsbyalphabet/tag.tpl',
        'tplEmpty' => '@FILE chunks/gettagsbyalphabet/empty.tpl',
        'snippet' => 'getTagsByAlphabet'
    ],
    'updateUser' => [
        'validate' => 'comment:requiredIf=^status|3^',
        'comment.vTextRequiredIf' => 'укажите причину отказа.',
        'snippet' => '@FILE snippets/designer/snippet.manageuser.php',
    ],
    'setStatusUsers' => [
        'hooks' => '',
        'validate' => 'comment:requiredIf=^status|3^,selected_id:checkbox:required',
        'selected_id.vTextRequired' => 'Не выбрано ни одного ID',
        'comment.vTextRequiredIf' => 'укажите причину отказа.',
        'snippet' => '@FILE snippets/designer/snippet.manageuser.php',
    ],
    'removeUsers' => [
        'extends' => 'setStatusUsers'
    ],
    'generate_report' => [
        'hooks' => '',
        'validate' => 'names:checkbox:required',
        'names.vTextRequired' => 'Выберите данные',
        'snippet' => '@FILE snippets/report/snippet.generatereport.php',
    ]
];