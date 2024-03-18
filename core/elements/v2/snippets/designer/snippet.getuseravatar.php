<?php

if($modx->user->isAuthenticated()){
    $profile = $modx->user->getOne('Profile');
    return $SendIt->success('', ['photo' => $profile->get('photo')]);
}
return $SendIt->error('', ['photo' => '']);