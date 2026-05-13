delete from public.community_notifications
where notification_type in ('chat_message', 'incoming_call');
