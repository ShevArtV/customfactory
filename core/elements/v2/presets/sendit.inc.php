<?php

return [
    'register' => [
        'hooks' => 'Identification,FormItSaveForm,FormItAutoResponder',
        'method' => 'register',
        'successMessage' => 'Вы успешно зарегистрированы. Подтвердите email для активации учётной записи.',

        'fiarSubject' => 'Активация пользователя',
        'fiarFrom' => 'robot@customfactory.ru',
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

        'redirectTo' => 28,
        'redirectTimeout' => 3000,
        'usernameField' => 'email',

        'email.vTextRequired' => 'Укажите email.',
        'password.vTextRequired' => 'Введите пароль.',
        'errorFieldName' => 'errorLogin'
    ],
    'logout' => [
        'hooks' => 'Identification',
        'method' => 'logout',
        'successMessage' => 'До новых встреч!',
        'redirectTo' => 1,
        'errorFieldName' => 'errorLogout'
    ],
    'forgot' => [
        'hooks' => 'Identification,FormItSaveForm,FormItAutoResponder',
        'method' => 'forgot',
        'successMessage' => 'Новый пароль отправлен на ваш email',

        'usernameField' => 'email',
        'validate' => 'email:required:userNotExists',

        'fiarSubject' => 'Восстановление пароля',
        'fiarFrom' => 'robot@customfactory.ru',
        'fiarTpl' => 'siResetPassEmail',

        'email.vTextRequired' => 'Укажите email.',
        'email.vTextUserNotExists' => 'Пользователь не найден',
    ],
    'acceptoffer' => [
        'hooks' => 'Identification',
        'method' => 'update',
        'successMessage' => 'Оферта принята.',
        'clearFieldsOnSuccess' => 0,
        'validate' => 'extended[offer]:checkbox:required',
        'extended[offer].vTextRequired' => 'Примите оферту.'
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
        extended[surname]:onlyCyrillic:required,
        extended[name]:onlyCyrillic:required,
        extended[fathername]:onlyCyrillic:required,
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
        extended[inn_img]:checkbox:requiredIf=^legal_form|ИП^,
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
        'allowExt' => 'jpg,png,jpeg,webp',
        'portion' => 1,
        'threadsQuantity' => 12,
    ],
    'upload_screens' => [
        'hooks' => '',
        'maxSize' => 0.5,
        'maxCount' => 3,
        'allowExt' => 'jpg,png,jpeg,webp',
        'portion' => 0.1,
        'threadsQuantity' => 12,
    ],
    'upload_excel' => [
        'hooks' => '',
        'maxSize' => 1,
        'maxCount' => 1,
        'allowExt' => 'xls,xlsx',
        'portion' => 0.1,
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
    'reloadFiles' => [
        'hooks' => '',
        'validate' => 'filelist:required',
        'filelist.vTextRequired' => 'Загрузите новые макеты',
        'snippet' => '@FILE snippets/product/snippet.reloadfiles.php',
        'clearFieldsOnSuccess' => 1,
    ],
    'upload_design' => [
        'hooks' => '',
        'maxSize' => 2000,
        'maxCount' => 3,
        'allowExt' => 'tiff,tif',
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
        'hooks' => '',
        'snippet' => '@FILE snippets/designer/snippet.manageuser.php',
        'validate' => 'comment:requiredIf=^status|3^',
        'comment.vTextRequiredIf' => 'Укажите причину отказа.',
    ],
    'setStatusUsers' => [
        'extends' => 'updateUser',
        'validate' => 'comment:requiredIf=^status|3^,selected_id:checkbox:required',
        'selected_id.vTextRequired' => 'Не выбрано ни одного ID',
    ],
    'unactiveUsers' => [
        'extends' => 'setStatusUsers'
    ],
    'updateProduct' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.manageproduct.php',
        'validate' => 'content:requiredIf=^status|5^,selected_id:checkbox:required',
        'content.vTextRequiredIf' => 'Укажите причину отказа.',
        'selected_id.vTextRequired' => 'Не выбрано ни одного ID',
        'clearFieldsOnSuccess' => 1,
    ],
    'changeStatus' => [
        'extends' => 'updateProduct',
        'clearFieldsOnSuccess' => 0,
    ],
    'changeParent' => [
        'extends' => 'updateProduct',
    ],
    'changeRootId' => [
        'extends' => 'updateProduct',
    ],
    'changeTags' => [
        'extends' => 'updateProduct',
    ],
    'changeColor' => [
        'extends' => 'updateProduct',
    ],
    'changeDeleted' => [
        'extends' => 'updateProduct',
    ],
    'toRework' => [
        'hooks' => '',
        'validate' => 'content:requiredIf=^status|7^,selected_id:checkbox:required',
        'snippet' => '@FILE snippets/product/snippet.torework.php',
        'fieldNames' => 'content==Комментарий'
    ],
    'generate_report' => [
        'hooks' => '',
        'validate' => 'names:checkbox:required',
        'names.vTextRequired' => 'Выберите данные',
        'snippet' => '@FILE snippets/report/snippet.generatereport.php',
    ],
    'load_workflow' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.loadworkflow.php',
        'successMessage' => '',
    ],
    'getfilesproducts' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.getproductsfromfile.php',
        'successMessage' => '',
    ],
    'base_form' => [
        'hooks' => 'FormItSaveForm,email',
        'validationErrorMessage' => 'Исправьте, пожалуйста, ошибки!',
        'successMessage' => 'Форма успешно отправлена! Менеджер свяжется с Вами в течение 5 минут.',
        'emailTo' => 'support@customfactory.ru,shev.art.v@yandex.ru',
        'emailFrom' => 'robot@customfactory.ru',
        'validate' => 'email:email:required,name:required,message:required:minLength=^10^:maxLength=^200^',
        'fieldNames' => 'name==Имя,email==Email,message==Сообщение,phone==Телефон',
    ],
    'default_products' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.getdefaultproducts.php',
        'successMessage' => '',
    ],
    'get_totals' => [
        'hooks' => '',
        'snippet' => '@FILE snippets/product/snippet.getstatistictotal.php',
        'successMessage' => '',
    ]
];
